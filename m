Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUCBHvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 02:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUCBHvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 02:51:52 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1435 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261502AbUCBHvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 02:51:49 -0500
Date: Mon, 1 Mar 2004 23:50:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: benh@kernel.crashing.org, jsimmons@infradead.org,
       arief_m_utama@telkomsel.co.id, linux-kernel@vger.kernel.org
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
Message-Id: <20040301235059.7bc8bba5.pj@sgi.com>
In-Reply-To: <20040301190816.5ed4e241.pj@sgi.com>
References: <Pine.LNX.4.44.0403020019340.7718-100000@phoenix.infradead.org>
	<1078187189.21575.165.camel@gaston>
	<20040301190816.5ed4e241.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "do { return ...; } while(0)" part was programmed
by a mind numbed robot.

This might be a step less insane for the macro part:

#define memcmp_all_but(s1, s2, TYPE, MEMBER)		\
	_memcmp_all_but(s1, s2, sizeof(TYPE),		\
			offsetof(TYPE, MEMBER),		\
			sizeof((TYPE *)0)->MEMBER);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
