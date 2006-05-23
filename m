Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWEWPWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWEWPWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWEWPWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:22:16 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:33930 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751338AbWEWPWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hXSVXi3zSjoq7/BqvqufMaHRBPV59WuE3IOW660IC7JO+a6XNC/2MBCVOtJx+j+V2EUQCQAgeSqqnOIB56yaRGoia93eWpeANyPetTZIek+uuukxocwqH0WT53mqPlyo21cp9wk0+AF9cYYMvgyrIqYDFctwRriPxE05DVmB2fc=
Message-ID: <aa4c40ff0605230822r34230211o9fa276234545dd59@mail.gmail.com>
Date: Tue, 23 May 2006 08:22:15 -0700
From: "James Lamanna" <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Sense data errors trying to read from tape - 2.6.14-gentoo-r5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/06, James Lamanna <jlamanna@gmail.com> wrote:
> Was trying to do an 'amrestore /dev/nst0' when I received the following OOPS:
>

[SNIP]

> I've also had problems restoring large XFS partitions off of tape
> (amrestore returns with input/output errors), but I'm not sure whether
> that is kernel or userspace related (no errors in dmesg or anything).
> In that case, amrestore did not have any problems restoring TAR-ed
> filesystems from tape (that was with 2.6.14-gentoo-r5).
>

[SNIP]

As a follow-up to the above on 2.6.14-gentoo-r5, while trying to
restore an XFS partition off of the tape (amrestore/dd doesn't oops on
this kernel) my dmesg fills with the following:

st0: Error with sense data: <6>st0: Current: sense key=0xb
    ASC=0x4b ASCQ=0x0

the command I'm running specifically is:
dd bs=32k skip=1 count=520531 conv=noerror,notrunc if=/dev/nst0 of=fs0restore

As you can see, my backups are not going as well as I had planned.

Thanks again.

-- James Lamanna
