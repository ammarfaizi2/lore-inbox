Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUFBMOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUFBMOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUFBMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:14:10 -0400
Received: from [213.146.154.40] ([213.146.154.40]:26752 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262450AbUFBMNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:13:46 -0400
Date: Wed, 2 Jun 2004 13:13:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org, Al Piszcz <apiszcz@solarrain.com>
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network?
Message-ID: <20040602121341.GA1023@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	linux-kernel@vger.kernel.org, Al Piszcz <apiszcz@solarrain.com>
References: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 08:04:06AM -0400, Piszcz, Justin Michael wrote:
> root@jpiszcz:~# mkdir /p500/dev
> root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
> root@jpiszcz:~# echo blah > /p500/dev/null
> root@jpiszcz:~# ls -l /p500/dev/null
> crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
> root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null
> 
> 6179737+0 records in
> 6179736+0 records out
> 
> Instead it treats it as a local block device?

character device actually.  Anyway, nfs never forwarded device files, the
protocol can't handle all the ioctl() variants anyway.

and how else would root on nfs work? :)

