Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTESKP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTESKP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:15:58 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:18184 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S262192AbTESKP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:15:57 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm7
Date: Mon, 19 May 2003 12:30:05 +0200
User-Agent: KMail/1.5.1
References: <20030519012336.44d0083a.akpm@digeo.com>
In-Reply-To: <20030519012336.44d0083a.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305191230.06092.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 May 2003 10:23, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69
>-mm7/
>
> . Included most of the new AIO code which has been floating about.  This
>   all still needs considerable thought and review, but we may as well get
> it under test immediately.
>
> . Lots of little fixes, as usual.

and this became broken:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.69-mm7; fi
WARNING: /lib/modules/2.5.69-mm7/kernel/fs/ext2/ext2.ko needs unknown symbol 
__bread_wq

__bread_wq is introduced in -mm7, someone forgot to export it?

	Rudmer
