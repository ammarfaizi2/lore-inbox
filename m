Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267742AbTATAay>; Sun, 19 Jan 2003 19:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTATAay>; Sun, 19 Jan 2003 19:30:54 -0500
Received: from tsv.sws.net.au ([203.36.46.2]:3334 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S267742AbTATAaw>;
	Sun, 19 Jan 2003 19:30:52 -0500
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Christoph Hellwig <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [RFC][PATCH] Add LSM sysctl hook to 2.5.59
Date: Mon, 20 Jan 2003 01:39:39 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <200301172154.QAA00757@moss-shockers.ncsc.mil> <20030120000853.A9023@infradead.org>
In-Reply-To: <20030120000853.A9023@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301200139.39092.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 01:08, Christoph Hellwig wrote:
> On Fri, Jan 17, 2003 at 04:54:37PM -0500, Stephen D. Smalley wrote:
> > This patch adds a LSM sysctl hook for controlling access to
> > sysctl variables to 2.5.59, split out from the lsm-2.5 BitKeeper tree.
> > SELinux uses this hook to control such accesses in accordance with the
> > security policy configuration.
>
> I'm not very happy with this hook.  This means every single security
> module needs a list of all sensitive sysctl variables, i.e. we duplicate
> information in (possible a large number of) different places.
>
> What's the reason you can't just live with DAC for sysctls?

What exactly do you mean by "live with DAC" in this context?  If you mean 
"allow UID==0 processes to do whatever they like" then it's not going to work 
for any sort of chroot setup.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

