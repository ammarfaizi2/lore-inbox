Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbTHUJnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHUJnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:43:15 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:45822 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S262452AbTHUJnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:43:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C367C8.A1BC2270"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH]: non-readable binaries - binfmt_misc, linux-2.6.0-test3  
Date: Thu, 21 Aug 2003 12:43:10 +0300
Message-ID: <2C83850C013A2540861D03054B478C0601CF6492@hasmsx403.iil.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: non-readable binaries - binfmt_misc, linux-2.6.0-test3  
Thread-Index: AcNiQsxxDKcp51DBSfClQqlqNOGM5QFhHPLA
From: "Zach, Yoav" <yoav.zach@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Aug 2003 09:43:10.0145 (UTC) FILETIME=[A1C1AB10:01C367C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C367C8.A1BC2270
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

This patch was posted on the list on August 14th ( with 'RO binaries'
instead of 'non-readable' ) and got no response. As it is very important
for us, I'd like to ask anyone who's involved with interpreters and
binfmt_misc to review the proposed patch and comment.

Thanks,
Yoav.

-----Original Message-----
From: Zach, Yoav=20
Sent: Thursday, August 14, 2003 12:03
To: linux-kernel@vger.kernel.org
Cc: Sharma, Arun; Mallick, Asit K
Subject: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3=20

The proposed patch solves a problem for interpreters that need to
execute a non-readable file, which cannot be read in userland. To handle
such cases the interpreter must have the kernel load the binary on its
behalf. The proposed patch handles this case by telling binfmt_misc, by
a special flag in the registration string, to open the binary for
reading and pass its descriptor as argv[1], instead of passing the
binary's path. Old behavior of binfmt_misc is kept for interpreters
which do not specify this special flag.

The patch is against linux-2.6.0-test3

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Yoav Zach
Performance Tools Lab
Intel Corp.



------_=_NextPart_001_01C367C8.A1BC2270
Content-Type: application/x-zip-compressed;
	name="2.4.binfmt_misc_open_binary.ZIP"
Content-Transfer-Encoding: base64
Content-Description: 2.4.binfmt_misc_open_binary.ZIP
Content-Disposition: attachment;
	filename="2.4.binfmt_misc_open_binary.ZIP"

UEsDBBQAAAAIALtNCi8nLxCdYQMAANQIAAAhAAAAMl80X2JpbmZtdF9taXNjX29wZW5fYmluYXJ5
LnBhdGNonVXpTttAEP7tSrzDlKoQY5v4QAQSQIHKrZDKodCinloZe51YdWxr1wHRNu/e2V07TppE
lEZRsh7P8c3MN7OWZUHM23dJFo9LMk54uBvu5iwZaq5te5a9b7ku2Idd1+16nV27/oBld2x744Vh
GEvmC5YH3T2v6x4sW/b7YHn75j4Y+HsA/f7GC8AvzSZj+OVnwV1KIxMugmESTnv44lVE4ySjcHF+
84a8vfhArgf+jT+49cnp4N2tDS3n6MhzdIS0pHl17V+Ss/PL08FnpWYLNRWvfCwo6gMv2SQs4ReK
tOqcJrwkIxpE8tRTkB3bFZgde890bIVaC0cBg50kC8aUBFHE4Bjkg4CtJVkJjJb3QdqTEQ0piaOe
OErLOCIY8avnfm9kOyjlBTpSL3sKr6YcodjyL6/8T/4bFSKG1kuqSqYLgTbMyxwIateonY7pdBC2
65lep4ItzbBtyyYI09KCNM0fyANLSswqDCnnrbuCja2TOEmp3hMqcTEpl4TNM+K8/Pj+vcxKBMNY
+CINhhy2VnZHF/U3NC2O0HRISzLJJpxGBJ9bunSj/ERwBHat/DRQobQCqhCvBqs1ha4atVgffJ4C
TTmtIWCXkoyXiESgM2E5EC8Y9l2CFw01YbMd0ft2HLVfR5smhqkUp+J3wfm/pLc6u9XJTWfc19o7
cDZJ0ggChj2Jc4a8LSkrMEuKHGzXLIGX65q3OIS6rgYIyzfO7xEuG5KflOUSmi65OhUUmVU3zItH
UY4kG3Lyg7KMpi3HhC2FXIFR1dSfz6Ino4gRm/e+UPYnrddhnNZVqzxIqjbskYVXtlie0DCWZntd
wGbBNOGeG0kuA69jHuIu2PdMp1q8TfDrDwPiDwatmkYqwPlNI1xeF3/NvPjrVUtk5hc5VQSMErwp
ULfVlAs5iJMO5YhKQygow2uEJ3nGIcgi3J24gJOSg9jEFSv/lwhrQaxMAMVjOua0nqy7SWzaJrq+
HlyQs49vyc35F7+yn4VQ/SIC9dxAol3jY6WHBe6tQfN0HtVsz5Pi5BhsvRrKypzTgIUjYR2wRzLC
KqeUSS8mlnvIZd9Fb7uKMO7hnryn3cPmztMKySc80LoJv4/X7YV68lXfdvBeO4btq+26P8qVscbV
XENn81XnWLn6lm3rc6D+AFBLAQIUCxQAAAAIALtNCi8nLxCdYQMAANQIAAAhAAAAAAAAAAEAIAAA
AAAAAAAyXzRfYmluZm10X21pc2Nfb3Blbl9iaW5hcnkucGF0Y2hQSwUGAAAAAAEAAQBPAAAAoAMA
AAAA

------_=_NextPart_001_01C367C8.A1BC2270--
