Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263970AbRFHLZG>; Fri, 8 Jun 2001 07:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263964AbRFHLY4>; Fri, 8 Jun 2001 07:24:56 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:14853 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S263965AbRFHLYq>; Fri, 8 Jun 2001 07:24:46 -0400
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: [CHECKER] security rules?  (and 2.4.5-ac4 security bug)
In-Reply-To: <E156VyD-0004D9-00@the-village.bc.nu>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 08 Jun 2001 13:24:18 +0200
In-Reply-To: <E156VyD-0004D9-00@the-village.bc.nu> (Alan Cox's message of "Sun, 3 Jun 2001 12:22:57 +0100 (BST)")
Message-ID: <tgwv6n43kt.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> n /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/random.c:1813:uuid_strategy: ERROR:RANGE:1809:1813: Using user length "len" as argument to "copy_to_user" [type=LOCAL] set by 'get_user':1813
> 
> Sigh I thought I had all of the sysctl ones

BTW uuid_strategy() is broken in the RANDOM_UUID case.  It calls
copy_to_user() on table->data, which is always NULL.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
