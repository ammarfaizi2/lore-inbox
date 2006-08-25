Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422911AbWHYVLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422911AbWHYVLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422912AbWHYVLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:11:35 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:19528 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422911AbWHYVLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:11:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Oob1nDJCOt+0gnTG/jiyPg1Aui/uTdrSZ28w2EaViUU2I5VpLEX9sNuCYRkiOWD9JfQMxOShq9Xnqth7hrPdBxBEhcgeSMqCiUPw7BxXOsc+eseBR8hLQFoNTc86ODUCVcfLsHjSAk0D8oweZ2hhOkyAFTYihbFKhfIM3GujZO0=
Message-ID: <361d23520608251411g256804d8t678a98e0ff552454@mail.gmail.com>
Date: Fri, 25 Aug 2006 17:11:34 -0400
From: "David Kyle" <david.kyle@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: TPM module: lack of internal kernel interface
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working on implementing a trusted computing system using
the linux TPM driver, similar to enforcer
(http://enforcer.sourceforge.net).  As my project involves kernel
modifications that are highly unlikely to be of use within the
mainstream kernel, I am attempting to confine my kernel-level work to
a linux security module, so that my system will hopefully not be
affected too heavily by newer kernel versions.

Hovever, I have run into difficulty since the TPM driver included in
the kernel doesn't include a internal interface for TPM access from
within the kernel itself.  There is only a userspace character device
interface.  Is there in fact an internal TPM interface I'm not seeing?
 If not, is there a particular reason why there isn't (and shouldn't
be) one?

It seems to me that it would be important to have such an interface
for any trusted computing system.  Enforcer uses it's own tpm kernel
driver, which I'd definately like to avoid doing with my project.

If I were to extend the existing TPM driver with an internal kernel
interface, would it likely be included in the mainstream kernel?

Thanks,
David Kyle
