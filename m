Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272977AbTGaKkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272979AbTGaKkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:40:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:43185 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272977AbTGaKkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:40:06 -0400
Message-ID: <3F28F3A1.B7114CD@in.ibm.com>
Date: Thu, 31 Jul 2003 16:16:57 +0530
From: Raj Inguva <rajsk@in.ibm.com>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <kksx@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: atomic_set & gcc. atomicity question
References: <E19iAEA-0006Fy-00.kksx-mail-ru@f6.mail.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #define atomic_set(v,i)         (((v)->counter) = (i))

'v' is of type atomic_t which is a structure.

> If we call atomic_set() with constant 2nd argument it's ok - it's a > simple write to var. But what if we do atomic_set(var, var1+var2)?

It will expand to (((var)->counter) = (var1+var2))

'counter' is 'volatile' .
