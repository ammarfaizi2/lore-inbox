Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTI2VYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTI2VYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:24:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30995 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263019AbTI2VYn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:24:43 -0400
Message-ID: <3F78A2FF.6070203@zytor.com>
Date: Mon, 29 Sep 2003 14:24:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ULL fixes for qlogicfc
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org> <bla4fg$pbp$1@cesium.transmeta.com> <3F789FE8.6050504@pobox.com>
In-Reply-To: <3F789FE8.6050504@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h8TLOGi28935
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> H. Peter Anvin wrote:
> 
>> 0xffffffff is unsigned int and will be promoted to
> 
> 0xffffffff without a prefix is signed.

No, it's not.

ISO/IEC 9899:1999(E) §6.4.4.1, page 55f:

5 The type of an integer constant is the first of the corresponding list
in which its value can be represented.

Suffix		Decimal Constant	Octal or Hexadecimal
					Constant

none		int			int
		long int 		unsigned int
		long long int		long int
					unsigned long int
					long long int
					unsigned long long int

... so 0x7fffffff is signed int, but 0xffffffff is unsigned int on an
I32-model system (all Linux systems are I32-model.)

	-hpa

