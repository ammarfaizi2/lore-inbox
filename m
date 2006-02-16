Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWBPSLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWBPSLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWBPSLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:11:17 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:64069 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932468AbWBPSLQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:11:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QtrXs3+Gz6mpNmwd1KBdpHi4YsATFkKXDSXXR9j+/M7R4MQbu/rnCQ8eJ4C8VRfdrTMmLUeBIcDEgUF55SEh9zdkVVpvMr6Dkjnb/mIta6m+jGXUG7p9rTaS1E5G/3ATffxYPxDdOf8h8ZnzdBv6CrbpgGlm7cR7O8UPWw+AWHw=
Message-ID: <a36005b50602161011v237a4e22x436716103c7c6b88@mail.gmail.com>
Date: Thu, 16 Feb 2006 10:11:15 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] FUTEX: one more return .
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200602161742.k1GHgs2m029392@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602161742.k1GHgs2m029392@dhcp153.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/06, Daniel Walker <dwalker@mvista.com> wrote:
> Continue the theme of returns .

No, that's wrong.  I got Ingo to remove this code and he documented it:

=====
- race fix: do not bail out in the list walk when the list_op_pending
   pointer cannot be followed by the kernel - another userspace thread
   may have already destroyed the mutex (and unmapped it), before this
   thread had a chance to clear the field.
=====
