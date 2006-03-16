Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWCPSxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWCPSxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWCPSxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:53:54 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:43166 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964838AbWCPSxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:53:53 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 16 Mar 2006 18:53:37 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, aia21@cantab.net, len.brown@intel.com
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
In-Reply-To: <Pine.LNX.4.64.0603161840470.31173@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603161853250.31173@hermes-2.csi.cam.ac.uk>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
 <20060316160129.GB6407@infradead.org> <20060316082951.58592fdc.rdunlap@xenotime.net>
 <20060316163001.GA7222@infradead.org> <20060316083654.d802f3f3.rdunlap@xenotime.net>
 <20060316163621.GA7519@infradead.org> <Pine.LNX.4.64.0603161640230.31173@hermes-2.csi.cam.ac.uk>
 <20060316165035.GU27946@ftp.linux.org.uk> <Pine.LNX.4.64.0603161840470.31173@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006, Anton Altaparmakov wrote:

> On Thu, 16 Mar 2006, Al Viro wrote:
> > On Thu, Mar 16, 2006 at 04:42:29PM +0000, Anton Altaparmakov wrote:
> > > Again, in your opinion.  To me it is a simple consequence of there not 
> > > being a boolean type in the kernel so you cannot use it in the core code.  
> > > Once there is such a type I would imagine users will appear in the core 
> > > code over time.
> > 
> > And that's supposed to be an argument in favour of that crap?
> 
> No, it was an alternative interpretation to Christoph's statement that the 
> non-use of booleans was due to them being crap.  So I said that you can't 
> use what you don't have and I imagine the majority of people do not want 
> these pointless flamewars so no-one has so far bothered to introduce a 
> generic bollean type in the kernel...
> 
> Andy why is it crap?  For a start it is valid C (well, ok C99, but even 

s/Andy/And/...

> you are fond of a lot of C99 features like the initializers) and second 
> it makes code more readable and makes meaning of functions a lot more 
> obvious, e.g reading:
> 
> "extern bool foo_is_compressed(bar);"
> 
> in a header file makes it damn obvious that if foo_is_compressed() returns 
> "true" then "bar" is compressed and if it returns "false" then "bar" is 
> not compressed.
> 
> If you see:
> 
> "extern int foo_is_compressed(bar);"
> 
> You have to go find the .c file containing the function and read it to 
> figure out what the heck the return value means/is.  And don't tell me you 
> can rely on it returning 0 for not-compressed and 1 for compressed.  For a 
> start it could return < 0 for error and a myriad of other things.  
> Especially in the kernel core the functions like that seem to randomly 
> return 0 for true and 1 for false and worse.  But even if they were 
> consistent you could never rule out the < 0 for error case unless you read 
> the function itself.
> 
> So I beg to differ with your opinion of boolean type being crap.
> 
> As you might have noticed already, I think booleans have their place and 
> make code much more readable when used appropriately.  I have only been 
> programming for the last 24 years and I like booleans and no-one is going 
> to get me to think otherwise after such a long time...
> 
> I am happy to agree that we disagree.  Just stay away with s/true/1/ 
> and s/false/0/ conversions from fs/ntfs/ please and I will shut up...  (-:
> 
> Best regards,
> 
> 	Anton
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
