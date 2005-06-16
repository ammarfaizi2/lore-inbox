Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVFPDxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVFPDxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 23:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVFPDxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 23:53:12 -0400
Received: from mail.aknet.ru ([82.179.72.26]:23312 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261724AbVFPDxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 23:53:07 -0400
Message-ID: <42B0F7A4.50802@aknet.ru>
Date: Thu, 16 Jun 2005 07:53:08 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz
Subject: Re: [patch 1/2] pcspeaker driver update
References: <42AF2454.8090806@aknet.ru>	<20050614134518.68df565d.akpm@osdl.org>	<42B056A3.4040202@aknet.ru> <20050615133338.398febbc.akpm@osdl.org>
In-Reply-To: <20050615133338.398febbc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
> Well not really - for example you now have drivers/input/joystick/analog.c
> including asm/8253pit.h, which not all architectures implement.
> The basic problem is that we have generic code referring to an x86-specific
> lock inside `#ifdef __i386__'.
In this case - what if I simply include
that <asm/8253pit.h> under the same
#ifdefs that are used for the spin-locks?
Or is it not recommended to #ifdef the
includes?

