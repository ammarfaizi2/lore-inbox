Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbUL2MaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUL2MaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 07:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbUL2MaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 07:30:11 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:24297 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261208AbUL2M37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 07:29:59 -0500
Date: Wed, 29 Dec 2004 13:29:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] whitespace cleanups in fs/cifs/file.c
Message-ID: <20041229122932.GC10308@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost> <1104104286.16545.7.camel@localhost.localdomain> <Pine.LNX.4.61.0412290048150.3528@dragon.hygekrogen.localhost> <20041229015716.GB29323@wohnheim.fh-wedel.de> <Pine.LNX.4.61.0412290347020.28589@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0412290347020.28589@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 December 2004 03:59:55 +0100, Jesper Juhl wrote:
> 
> > > @@ -408,7 +410,7 @@ cifs_close(struct inode *inode, struct f
> > >  	struct cifs_sb_info *cifs_sb;
> > >  	struct cifsTconInfo *pTcon;
> > >  	struct cifsFileInfo *pSMBFile =
> > > -		(struct cifsFileInfo *) file->private_data;
> > > +		(struct cifsFileInfo *)file->private_data;
> > 
> > 	struct cifsFileInfo *pSMBFile = file->private_data;
> > 
> > Casting a typeless pointer is pointless.
> > 
> This was a 'whitespace fixes only' patch. I have no problem with going 
> through the file and looking for pointless casts etc, but that would be a 
> sepperate patch.

Sure.  I noticed it while going through your patch, that's all.  If
you find the time for a second patch, that would be nice.  Casts are a
very effective obfuscation method and most are pretty simple to avoid.
Maybe I should check the kernel janitor list and add this point, if
it doesn't exist yet.

> > > -	if(file->f_dentry) {
> > > -		if(file->f_dentry->d_inode) {
> > > +	if (file->f_dentry) {
> > > +		if (file->f_dentry->d_inode) {
> > 
> > 	if (file->f_dentry && file->f_dentry->d_inode) {
> > 
> > There is too little context to see if this conversion is possible.
> > And I'm too lazy to check myself.
> > 
> I didn't check that either since that's not what this patch was about - it 
> was strictly formatting/whitespace cleanups and no code changes.

Yup.  Same as above, except for the janitor list.

> - there was a lot of lines in there ;)

You can say that again, Mr. Hat!

> I made those changes since (again) both styles are used in the file, so to 
> make it consistent I had to choose one of the styles, and picked my 
> personal preference - that's the only reason behind that change.

Personal style is hard to argue about.  And doesn't make much of a
difference anyway.

> > > -static void reset_resume_key(struct file * dir_file, 
> > > -				unsigned char * filename, 
> > > -				unsigned int len,int Unicode,struct nls_table * nls_tab) {
> > > +static void 
> > > +reset_resume_key(struct file *dir_file, unsigned char *filename,
> > > +		 unsigned int len, int Unicode, struct nls_table *nls_tab)
> > > +{
> > 
> > Lex Linus?  Either way you don't stay within the 80 column.
> > 
> Whoops, my bad, I intended to.

Sorry.  The whole function declaration is spread over three lines.  I
don't mind p***ing Linus off iff putting the return type on a seperate
line is sufficient to fit all the rest into a single line.  Doesn't
work here, so you get to argue in favor, not me. ;)

> Sepperate issue, sepperate patch.

Agreed.  Google proposes "separate", btw.  

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
