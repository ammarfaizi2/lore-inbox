Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbSIRG5W>; Wed, 18 Sep 2002 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265615AbSIRG5W>; Wed, 18 Sep 2002 02:57:22 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:6849 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265592AbSIRG5V>; Wed, 18 Sep 2002 02:57:21 -0400
Message-ID: <3D882500.2000105@redhat.com>
Date: Wed, 18 Sep 2002 00:02:24 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hardware limits on numbers of threads?
References: <3D88208E.8545AAA2@kegel.com>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dan Kegel wrote:
> http://people.redhat.com/drepper/glibcthreads.html says:
> 
> 
>>Hardware restrictions put hard limits on the number of 
>>threads the kernel can support for each process. 
>>Specifically this applies to IA-32 (and AMD x86_64) where the thread
>>register is a segment register. The processor architecture 
>>puts an upper limit on the number of segment register values 
>>which can be used (8192 in this case).
> 
> 
> Is this true?  Where does the limit come from?

This was and is true with the kernel before 2.5.3<mumble> when Ingo 
introduced TLS support since the thread specific data had to be 
addressed via LDT entries and the LDT holds at most 8192 entries.  The 
GDT based solution now implemented in the kernel has no such limitation 
and the number of threads you can create with the new thread library is 
only limited by system resources.

- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9iCUE2ijCOnn/RHQRAgqyAJ0e88AQXpxXoHrvZCxIhfZXJFJP9QCbBlCL
nXUfQkt00sX+XsHg89OZz+k=
=NkZd
-----END PGP SIGNATURE-----

