Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbRAKKgy>; Thu, 11 Jan 2001 05:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131202AbRAKKgo>; Thu, 11 Jan 2001 05:36:44 -0500
Received: from chiara.elte.hu ([157.181.150.200]:53773 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131200AbRAKKgg>;
	Thu, 11 Jan 2001 05:36:36 -0500
Date: Thu, 11 Jan 2001 11:36:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank Davis <fdavis112@juno.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: [patch] highmem-2.4.0-A0 (was: Re: 2.4.0-ac6: mm/vmalloc.c compile
 error)
In-Reply-To: <20010111.002835.-160337.1.fdavis112@juno.com>
Message-ID: <Pine.LNX.4.30.0101111129030.981-200000@e2>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-746993915-979209366=:981"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-746993915-979209366=:981
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 11 Jan 2001, Frank Davis wrote:

> Hello,
>   The following error occurred while compiling 2.4.0-ac6. [...]

> vmalloc.c: In function `get_vm_area':
> vmalloc.c:188: `PKMAP_BASE' undeclared (first use in this function)

you are compiling with HIGHMEM enabled (which makes sense only if you have
more than ~900MB RAM), and i accidentally broke HIGHMEM with the vmalloc
fix in -pre1/-ac5. The attached patch fixes it.

	Ingo

--655616-746993915-979209366=:981
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="highmem-2.4.0-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101111136060.981@e2>
Content-Description: 
Content-Disposition: attachment; filename="highmem-2.4.0-A0"

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvdm1hbGxvYy5oLm9yaWcJVGh1IEph
biAxMSAxMToyODowNiAyMDAxDQorKysgbGludXgvaW5jbHVkZS9saW51eC92
bWFsbG9jLmgJVGh1IEphbiAxMSAxMToyODozMyAyMDAxDQpAQCAtNCw2ICs0
LDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4NCiAjaW5jbHVkZSA8
bGludXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4NCisj
aW5jbHVkZSA8bGludXgvaGlnaG1lbS5oPg0KIA0KICNpbmNsdWRlIDxhc20v
cGd0YWJsZS5oPg0KIA0K
--655616-746993915-979209366=:981--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
