Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318262AbSGQLsc>; Wed, 17 Jul 2002 07:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSGQLsb>; Wed, 17 Jul 2002 07:48:31 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:32263 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S318262AbSGQLsa>; Wed, 17 Jul 2002 07:48:30 -0400
Date: Wed, 17 Jul 2002 13:51:25 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: close return value
Message-ID: <20020717115125.GD28284@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716.180521.57640174.davem@redhat.com> <Pine.LNX.4.44.0207161817560.4794-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207161817560.4794-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Linus Torvalds wrote:

> Yes, EAGAIN doesn't really work as a close return value, simply because
> _nobody_ expects that (and leaving the file descriptor open after a
> close() is definitely unexpected, ie people can very validly complain
> about buggy behaviour).

non-issue, since EAGAIN would violates the specs that don't list EGAIN
(and EAGAIN in response does not make sense either, the kernel should
then try harder to get the I/O completed).

-- 
Matthias Andree
