Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272231AbTHNJCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTHNJCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:02:50 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:9673 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S272231AbTHNJCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:02:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36242.D34564DF"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3  
Date: Thu, 14 Aug 2003 12:02:44 +0300
Message-ID: <2C83850C013A2540861D03054B478C0601CF646D@hasmsx403.iil.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: RO binaries - binfmt_misc, linux-2.6.0-test3  
Thread-Index: AcNiQsxxDKcp51DBSfClQqlqNOGM5Q==
From: "Zach, Yoav" <yoav.zach@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Sharma, Arun" <arun.sharma@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 14 Aug 2003 09:02:45.0306 (UTC) FILETIME=[D38C59A0:01C36242]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36242.D34564DF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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



------_=_NextPart_001_01C36242.D34564DF
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

------_=_NextPart_001_01C36242.D34564DF--
