Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSEMJxO>; Mon, 13 May 2002 05:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSEMJxO>; Mon, 13 May 2002 05:53:14 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:7698 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310769AbSEMJxN>;
	Mon, 13 May 2002 05:53:13 -0400
Date: Mon, 13 May 2002 01:52:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
Message-ID: <20020513085227.GA9059@kroah.com>
In-Reply-To: <20020512203103.GA9087@gallifrey> <Pine.LNX.4.44.0205121836320.15555-100000@home.transmeta.com> <20020513093142.GB13532@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 15 Apr 2002 07:41:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 11:31:42AM +0200, Matthias Andree wrote:
> 
> I sent a first version of a Perl program to Linus, a copy of the program
> is available at
> http://mandree.home.pages.de/linux/kernel/lk-changelog.pl
> (Yes I know the first $Log:$ entry is missing.)

Please make the following change to the patch, otherwise email address
(or other things within a <>) in the body of the change message are
improperly picked up.

Other than that minor problem, looks very nice.

thanks,

greg k-h

--- lk-changelog.pl~	Mon May 13 02:56:07 2002
+++ lk-changelog.pl	Mon May 13 02:59:05 2002
@@ -81,7 +81,7 @@
 
 while(<>) {
   chomp;
-  if (/<(.*?)>/) {
+  if (/^<(.*?)>/) {
     $author = $1;
     $first = 1;
   } elsif ($first) {
