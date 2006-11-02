Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752213AbWKBBWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbWKBBWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbWKBBWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:22:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:3220 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752213AbWKBBWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:22:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nU5cv+XlHA1Bj4lQ24dH+8D8omAAibGexG1/n5QALJ2/YI+dN9kAo7MMU/RJi09afhg4tTysi5Sa9s//0CyU+FIkrrOW+QxOnGbuh9rvVyYqZ25tm05GXmgAvMybe3jk0yLlFASxSItXR60uxPx/8uQ9UlLiyG1QEUOPV3Jr0wA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Date: Thu, 2 Nov 2006 02:23:42 +0100
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, Neil Horman <nhorman@tuxdriver.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <200611020144.51196.jesper.juhl@gmail.com> <454945FA.8030901@oracle.com>
In-Reply-To: <454945FA.8030901@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020223.43011.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 02:12, Randy Dunlap wrote:
> Jesper Juhl wrote:
> > On Thursday 02 November 2006 01:27, Andrew Morton wrote:
> >> On Wed, 1 Nov 2006 16:11:55 -0800
> >> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> >>
> >>>> Hmm, I guess that should be defined once and for all in
> >>>> Documentation/CodingStyle
> >>> I have some other CodingStyle changes to submit, but feel free
> >>> to write this one up.
> >> Starting labels in column 2 gives me the creeps, personally.  But there's a
> >> decent justification for it.
> >>
> >>> However, I didn't know that we had a known style for this, other
> >>> than "not indented so far that it's hidden".
> >>>
> >>> If a label in column 0 [0-based :] confuses patch, then that's
> >>> a reason, I suppose.  I wasn't aware of that one...
> >>> In a case like that, we usually say "fix the tool then."
> >> The problem is that `diff -p' screws up and displays the label: in the
> >> place where it should be displaying the function name.
> >>
> >> Of course, lots of people forget the -p anyway...  Maybe we can fix those
> >> tools ;)
> >>
> > Until the tools get fixed, how about applying this patch ?
> > 
> > 
> > Add CodngStyle info on labels.
> > 
[snip]
> > +generally it is prefered that labels be placed at column 1.
> 		~~~~~~~~~~~~
> 		preferred
> 
> I would also say something like this:
> 
> Labels should stand out -- be easily visible.  They should not be
> indented so much that they are hidden or obscured by the surrounding
> source code.
> 
Ok, how's this :

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 29c1896..4f6b2d5 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -566,6 +566,21 @@ result.  Typical examples would be funct
 NULL or the ERR_PTR mechanism to report failure.
 
 
+		Chapter 17: Labels
+
+Label names should be lowercase.
+
+Label names should start with a letter [a-z].
+
+Labels should not be placed at column 0. Doing so confuses some tools, most
+notably 'diff' and 'patch'. Instead place labels at column 1 (indented 1
+space). In some cases it's OK to indent labels one or more tabs, but
+generally it is preferred that labels be placed at column 1.
+
+Labels should stand out - be easily visible. They should not be indented so
+much that they are hidden or obscured by the surrounding source code.
+
+
 
 		Appendix I: References
 



