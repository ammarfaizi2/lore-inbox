Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVEDRcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVEDRcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVEDRa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:30:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33710 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261268AbVEDRZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:25:27 -0400
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment
	policy
From: Dave Hansen <haveblue@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200505041716.j44HGPbV016851@turing-police.cc.vt.edu>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
	 <200505041716.j44HGPbV016851@turing-police.cc.vt.edu>
Content-Type: multipart/mixed; boundary="=-yu8ft/4Q2TAeFdb8vHh6"
Date: Wed, 04 May 2005 10:25:16 -0700
Message-Id: <1115227516.22718.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yu8ft/4Q2TAeFdb8vHh6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-05-04 at 13:16 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 04 May 2005 10:01:56 PDT, Dave Hansen said:
> 
> > -6) No MIME, no links, no compression, no attachments.  Just plain text.
> > +6) No MIME, no links, no compression.  Just plain text.
> 
> Logically buggy.  You can't have an attachment without the MIME markup that
> *says* it's an attachment.  I think what you meant was "No Content-Type-Encoding":
> i.e. 'none' is acceptable, but 'quoted-printable' (which causes all the
> spurious =20 and =3D you sometimes see) and 'base64' (uuencode on steroids)
> aren't....

Thanks for pointing out my flawed logic.  I wasn't quite sure what was
MIME and what wasn't.  How about the attached patch, instead?

-- Dave

--=-yu8ft/4Q2TAeFdb8vHh6
Content-Disposition: attachment; filename=submitting-patches-1.patch
Content-Type: text/x-patch; name=submitting-patches-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit


I think the general opinion of posting patches as attachments
has changed over the last few years.  Mailers have been getting
a lot better at handling them, even quoting non-message-body
plain/text attachments in replies.  

Plus, a plain/text attachment message saved to a file can go
into 'patch' the same way that an inline one can.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/Documentation/SubmittingPatches |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff -L Documentation/Submitting -puN /dev/null /dev/null
diff -puN Documentation/SubmittingPatches~submitting-patches Documentation/SubmittingPatches
--- memhotplug/Documentation/SubmittingPatches~submitting-patches	2005-05-04 08:07:25.000000000 -0700
+++ memhotplug-dave/Documentation/SubmittingPatches	2005-05-04 10:22:43.000000000 -0700
@@ -181,25 +181,33 @@ patches. Trivial patches must qualify fo
 
 
 
-6) No MIME, no links, no compression, no attachments.  Just plain text.
+6) No links, no compressed attachments.  Just plain text.
 
 Linus and other kernel developers need to be able to read and comment
 on the changes you are submitting.  It is important for a kernel
 developer to be able to "quote" your changes, using standard e-mail
 tools, so that they may comment on specific portions of your code.
 
-For this reason, all patches should be submitting e-mail "inline".
+For this reason, the preferred way of submitting patches in e-mail is
+"inline", in the same part of the message with everything else.
 WARNING:  Be wary of your editor's word-wrap corrupting your patch,
 if you choose to cut-n-paste your patch.
 
-Do not attach the patch as a MIME attachment, compressed or not.
+Many maintainers will now accept patches submitted to them as
+text/plain attachments.  Many mailers quote these attachements in the
+same way that they do for inline patches.  But, some maintainers still
+prefer inlines and they are certainly the safest bet.  In any case,
+never attach more than one patch to a single e-mail.
+
 Many popular e-mail applications will not always transmit a MIME
 attachment as plain text, making it impossible to comment on your
-code.  A MIME attachment also takes Linus a bit more time to process,
-decreasing the likelihood of your MIME-attached change being accepted.
+code.  If you must use an attachment, verify that it has no
+Content-Type-Encoding.  A MIME attachment also takes Linus a bit more
+time to process, decreasing the likelihood of your MIME-attached
+change being accepted.
 
 Exception:  If your mailer is mangling patches then someone may ask
-you to re-send them using MIME.
+you to re-send them compressed or using other MIME encodings.
 
 
 
_

--=-yu8ft/4Q2TAeFdb8vHh6--

