Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316954AbSF0UWC>; Thu, 27 Jun 2002 16:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316955AbSF0UWB>; Thu, 27 Jun 2002 16:22:01 -0400
Received: from mail.webmaster.com ([216.152.64.131]:25045 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S316079AbSF0UV7> convert rfc822-to-8bit; Thu, 27 Jun 2002 16:21:59 -0400
From: David Schwartz <davids@webmaster.com>
To: <marcelo@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 27 Jun 2002 13:24:14 -0700
In-Reply-To: <Pine.LNX.4.44.0206271558330.11719-100000@freak.distro.conectiva>
Subject: Re: [PATCH] shm_destroy lock hang
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020627202415.AAA1385@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Just please avoid doing that locking nastyness:
>
>function() {
>unlock();
>}
>
>
>lock();
>if (something)
>    function();
>else
>    unlock();

	What do you do in cases where 'function' looks like this:

function() {
 something();
 unlock();
 something_else();
}

	DS


