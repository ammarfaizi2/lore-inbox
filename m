Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWKBAnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWKBAnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWKBAnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:43:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:59379 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751407AbWKBAnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:43:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ad0bOQ/zLaeRPw5AaDAT7w/RcgAbKk5uISBOjGTViEpXg7BPcGtRmQSn/I8LDGA0v2nKwdHhObbmZAjw959WBKw9Hf17m3/23ecUl+FDS04/S3PrHDPC5+IwRxTFRpn1j9f0jzMunnV9lC5DWPWvm/f7JFLr4Xe75moLANRMt6o=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Date: Thu, 2 Nov 2006 01:44:50 +0100
User-Agent: KMail/1.9.4
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       "Neil Horman" <nhorman@tuxdriver.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <20061101161155.d7b30258.randy.dunlap@oracle.com> <20061101162727.72f1183b.akpm@osdl.org>
In-Reply-To: <20061101162727.72f1183b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020144.51196.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 01:27, Andrew Morton wrote:
> On Wed, 1 Nov 2006 16:11:55 -0800
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > > Hmm, I guess that should be defined once and for all in
> > > Documentation/CodingStyle
> > 
> > I have some other CodingStyle changes to submit, but feel free
> > to write this one up.
> 
> Starting labels in column 2 gives me the creeps, personally.  But there's a
> decent justification for it.
> 
> > However, I didn't know that we had a known style for this, other
> > than "not indented so far that it's hidden".
> > 
> > If a label in column 0 [0-based :] confuses patch, then that's
> > a reason, I suppose.  I wasn't aware of that one...
> > In a case like that, we usually say "fix the tool then."
> 
> The problem is that `diff -p' screws up and displays the label: in the
> place where it should be displaying the function name.
> 
> Of course, lots of people forget the -p anyway...  Maybe we can fix those
> tools ;)
> 
Until the tools get fixed, how about applying this patch ?


Add CodngStyle info on labels.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 29c1896..f8a3abb 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -566,6 +566,18 @@ result.  Typical examples would be funct
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
+generally it is prefered that labels be placed at column 1.
+
+
 
 		Appendix I: References
 



