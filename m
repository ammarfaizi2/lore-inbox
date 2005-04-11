Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVDKTnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVDKTnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVDKTnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:43:12 -0400
Received: from terrhq.ru ([81.222.97.18]:37830 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S261897AbVDKTnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:43:04 -0400
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Date: Mon, 11 Apr 2005 23:43:55 +0400
User-Agent: KMail/1.8
References: <20050325095838.GA9471@infradead.org> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504112343.56052.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, gentlemen, 
On 11 April 2005 23:10, you wrote:
>
> Christoph was not objcting to lack of choice, rather the opposite.  He
> would like to have only the "allow_other" behavior.
I think I could sched some light on this option. 
It was needed when I was implementing SMB-to-FS connector (basically mapping 
msnet into filesystem hierarchy), using smbmount to actually mount shares 
over fuse-supported directory tree. smbmount (and sbmnt, in turn) needs to be 
able to access mountpoint, and, unfortunately, this access is done under 
setuid(0). allow_other can't be used in many cases, f.e. when user mounts 
MSNet tree over /mnt  (and can't protect /mnt with standard and proper 
attributes ). 

-- 
Managing your Territory since the dawn of times ...
