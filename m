Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292326AbSB0MJV>; Wed, 27 Feb 2002 07:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292353AbSB0MJL>; Wed, 27 Feb 2002 07:09:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53122 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292326AbSB0MI4> convert rfc822-to-8bit;
	Wed, 27 Feb 2002 07:08:56 -0500
Date: Wed, 27 Feb 2002 04:06:53 -0800 (PST)
Message-Id: <20020227.040653.58455636.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020227125611.A20415@stud.ntnu.no>
In-Reply-To: <20020227120549.A8734@stud.ntnu.no>
	<20020227.033455.13771237.davem@redhat.com>
	<20020227125611.A20415@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Wed, 27 Feb 2002 12:56:11 +0100
   
   tg3.c:v0.90 (Feb 25, 2002)
   DEBUG: counter 6592
   DEBUG: smallest_limit is 10000
   DEBUG: read_partno returned -19
   tg3: Problem fetching invariants of chip, aborting.
   
   smallest_limit is naturally 10k since limit isn't decremented...
   
Oh I see... ok so it gets the vital product data, but it
cannot find the part number string.

Please, simply make tg3_read_partno always return 0 (or,
alternatively, make tg3_get_invariants() ignore tg3_read_partno's
return value).  It should just work, this string is not critical to
the driver's operation.
