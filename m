Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280848AbRKBVad>; Fri, 2 Nov 2001 16:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280846AbRKBVaX>; Fri, 2 Nov 2001 16:30:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:28430 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280844AbRKBVaQ>;
	Fri, 2 Nov 2001 16:30:16 -0500
Subject: Re: query about use of IFDEFS
From: Robert Love <rml@tech9.net>
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE2A153.B9B06FD2@cisco.com>
In-Reply-To: <3BE2A153.B9B06FD2@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 02 Nov 2001 16:30:18 -0500
Message-Id: <1004736618.6141.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-02 at 08:36, Manik Raina wrote:
> which of the following be acceptable  in the linux kernel ?
> [...]

The first.  You want the code itself to be clean and clear; free of
ifdefs.

So in your header files you ifdef as needed.  The simplest example of
this would be with a define:

	#ifdef CONFIG_SMP
	#define special_smp_thing() whatever_smp()
	#else
	#define special_smp_thing()
	#endif

	Robert Love

