Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129630AbQJ3VFX>; Mon, 30 Oct 2000 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbQJ3VFO>; Mon, 30 Oct 2000 16:05:14 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12558 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129630AbQJ3VFE>;
	Mon, 30 Oct 2000 16:05:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17 
In-Reply-To: Your message of "Mon, 30 Oct 2000 18:16:44 -0000."
             <E13qJUE-00075t-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 08:04:57 +1100
Message-ID: <9624.972939897@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 18:16:44 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> 2.4 symbol generation code never sees the C++ names, 2.5 code might.
>> To detect a mismatch between kernel headers and the module version
>> file, I have to generate the checksum for the consumer of the symbol
>> (C++) as well as the generator of the symbol (C) and compare them.
>
>These are structure field names. They aren't part of a symbol and are only
>part of your checksum computation which is done on the C headers so a constant.
>
>If we were renaming variables or actual objects I'd agree. But structure names
>are fine so long as we only use C names for the module checksum computation

The checksum is done on the output from the preprocessor, not the
headers.  Changing field names via preprocessor flags gives different
checksums for structures.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
