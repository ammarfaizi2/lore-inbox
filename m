Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289319AbSAIKlA>; Wed, 9 Jan 2002 05:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289322AbSAIKku>; Wed, 9 Jan 2002 05:40:50 -0500
Received: from nile.gnat.com ([205.232.38.5]:45310 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289319AbSAIKkh>;
	Wed, 9 Jan 2002 05:40:37 -0500
From: dewar@gnat.com
To: Dautrevaux@microprocess.com, dewar@gnat.com, mrs@windriver.com,
        paulus@samba.org
Subject: RE: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020109104034.DA6D0F3135@nile.gnat.com>
Date: Wed,  9 Jan 2002 05:40:34 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<This is especially true as it is a nuisance for some uses of "volatile" that
were intended by the standard (as is clear in notes refering to the use of
volatile for memory mapped IO) and are broken by this optimization.
>>

Right, of course this optimization should only be done if the compiler can
prove that no other volatile objects are accessed (that would also violate
the corresponding rule in the Ada standard).
