Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290679AbSAYOIC>; Fri, 25 Jan 2002 09:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290680AbSAYOHv>; Fri, 25 Jan 2002 09:07:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:48389 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290679AbSAYOHg>;
	Fri, 25 Jan 2002 09:07:36 -0500
Subject: Re: O(1) on powerpc....
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: The Doctor What <docwhat@gerf.org>, linux-kernel@vger.kernel.org,
        Anton Blanchard <anton@samba.org>
In-Reply-To: <Pine.LNX.4.33.0201251651430.9011-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201251651430.9011-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 09:11:43 -0500
Message-Id: <1011967954.3501.17.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 10:52, Ingo Molnar wrote:

> i think Anton has patches to make PowerPC work - Anton?

We could do some things to generically make the other arches compatible
with the new scheduler, things like:

#define smp_processor_id()	(current->processor)

still need to be fixed (to use ->cpu).  I bet after a trivial
find/replace there is little left to do.

	Robert Love

