Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWDTQha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWDTQha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDTQha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:37:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:56858 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751079AbWDTQh3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:37:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HZOe3WI5iupAtTZRht+dANXVRrfd5yctFVhSH7V7wDhimQnI4wnB7jKAsp4k5xSs9VUbDtTkXBVMn+wHImknlty/HeEXaKd++KMsvNqz2XR110+8HpYDsyXzcjvYCsdfw5OOul6dkZbSBVj5SDnKHpyYp6KPPu/SBVeD/2YvtRA=
Message-ID: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
Date: Thu, 20 Apr 2006 09:37:27 -0700
From: "Robert Merrill" <grievre@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFS bug?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

we have an SMP login server we just recently switched to debian
testing from FreeBSD and it's giving us a little trouble.

it mounts its /home on a seperate machine, which is still running BSD,
over a NIC-to-NIC 1000BASE-T link.

We've found the following bug exists in 2.6.15 and .16: If a directory
under /home is readable but not executable, a call to getdents64() on
it will kill the process with an invalid operand error in
__copy_from_user_ll

has this been fixed already, and is there a patch which is readily applicable?

we're not using the latest kernel, unfortunately, because it has lockd problems.
