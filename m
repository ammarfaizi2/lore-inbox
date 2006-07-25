Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWGYUO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWGYUO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWGYUOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:14:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:63920 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030187AbWGYUOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:14:23 -0400
In-Reply-To: <Pine.LNX.4.64.0607251104380.21352@d.namei>
Subject: Re: [RFC][PATCH 2/6] Integrity Service API and dummy provider
To: James Morris <jmorris@namei.org>
Cc: David Safford <safford@us.ibm.com>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org,
       Serge E Hallyn <sergeh@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 Beta3NP May 09, 2006
Message-ID: <OF6DA008AE.385E4929-ON852571B6.006D8515-852571B6.006F98E0@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Tue, 25 Jul 2006 16:14:20 -0400
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 07/25/2006 16:14:22
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/25/2006 11:08:17 AM, James Morris wrote:

> On Mon, 24 Jul 2006, Kylene Jo Hall wrote:
>
> > + * @verify_data:
> > + *   Verify the integrity of a dentry.
> > + *   @dentry contains the dentry structure to be verified.
> > + *   Possible return codes are: INTEGRITY_PASS, INTEGRITY_FAIL,
> > + *       INTEGRITY_NOLABEL
> > + *
> > + * @verify_metadata:
> > + *   Verify the integrity of a dentry's metadata; return the value
> > + *    of the requested xattr_name and the verification result of the
> > + *   dentry's metadata.
> > + *   @dentry contains the dentry structure of the metadata to be
verified.
> > + *   @xattr_name, if not null, contains the name of the xattr
> > + *       being requested.
> > + *   @xattr_value, if not null, is a pointer for the xattr value.
> > + *   @xattr_val_len will be set to the length of the xattr value.
> > + *   @xattr_status is the result of the getxattr request for the
xattr.
> > + *   Possible return codes are: INTEGRITY_PASS, INTEGRITY_FAIL,
> > + *      INTEGRITY_NOLABEL, -EOPNOTSUPP, -ENOMEM,
>
> What I would suggest with these API calls is that they always only return

> errno values, and that you pass back the INTEGRITY_ values via a pointer.
>
> This ensures that errno values are cleanly propagated throughout the
> kernel and that 'system' errors are separated from higher level integrity

> service status values.

Yes, that definitely would be cleaner.  We'll include this change in the
next
set of patches.

Thank you.

Mimi Zohar

