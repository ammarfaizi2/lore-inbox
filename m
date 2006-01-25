Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWAYUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWAYUqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWAYUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:46:42 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:63935 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1750881AbWAYUql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:46:41 -0500
Date: Wed, 25 Jan 2006 21:46:19 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060125204619.GD12039@hardeman.nu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
References: <11380489522552@2gen.com> <16978.1138099067@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <16978.1138099067@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 10:37:47AM +0000, David Howells wrote:
>David Härdeman <david@2gen.com> wrote:
>
>> Adds the multi-precision-integer maths library which was originally taken
>> from GnuPG and ported to the kernel by David Howells in 2004
>> (http://people.redhat.com/~dhowells/modsign/modsign-269rc4mm1-2.diff.bz2)
>
>You should update these files from a latest Fedora, Rawhide or RHEL kernel to
>pick up the bug fixes that have been made.

Somewhat confusing...I downloaded kernel-2.6.15-1.1871_FC5.src.rpm and 
extracted linux-2.6-modsign-mpilib.patch from the srpm. After diffing 
the mpi dirs created by the previously mentioned patch and that from the 
Fedora kernel I get:

(david@austin:~/src/kernel/div)$ diff -Nurbw linux-2.6.9-rc4-mm1/crypto/mpi/ linux-902/crypto/mpi/
diff -Nurbw linux-2.6.9-rc4-mm1/crypto/mpi/mpi-div.c linux-902/crypto/mpi/mpi-div.c
--- linux-2.6.9-rc4-mm1/crypto/mpi/mpi-div.c    2006-01-24 22:56:09.000000000 +0100
+++ linux-902/crypto/mpi/mpi-div.c      2006-01-24 22:55:18.000000000 +0100
@@ -101,7 +101,7 @@
     MPI temp_divisor = NULL;
 
     if( quot == divisor || rem == divisor ) {
-       if (mpi_copy( &temp_divisor, divisor ) < 0);
+       if (mpi_copy( &temp_divisor, divisor ) < 0)
        return -ENOMEM;
        divisor = temp_divisor;
     }

Was that all the difference there was or am I missing something?

Re,
David
