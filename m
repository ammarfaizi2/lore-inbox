Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290440AbSAQUZI>; Thu, 17 Jan 2002 15:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290441AbSAQUY7>; Thu, 17 Jan 2002 15:24:59 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:13075 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S290440AbSAQUYq>;
	Thu, 17 Jan 2002 15:24:46 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200201172024.XAA04744@ms2.inr.ac.ru>
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
To: balbir_soni@hotmail.COM (Balbir Singh)
Date: Thu, 17 Jan 2002 23:24:27 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F96rPJjUsZ6G7KCk5sm0001ad67@hotmail.com> from "Balbir Singh" at Jan 17, 2 07:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The protocol specific code would like to look at what
> the user passed.

For what purpose?

Protocol has no rights to use this length, because user has right
to pass buffer of any length and address will be simply truncated.
And the truncation is made by net/socket.c, so that protocols need
not worry about this.

Alexey
