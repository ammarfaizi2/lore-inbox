Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTKYIVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 03:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTKYIVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 03:21:10 -0500
Received: from cs.columbia.edu ([128.59.16.20]:49131 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S262116AbTKYIVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 03:21:08 -0500
Message-Id: <200311250821.hAP8L6OW006754@sutton.cs.columbia.edu>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Replacing tcp_v4_rcv from a module
Reply-To: "Gong Su" <gongsu@cs.columbia.edu>
X-face: (/hxHkDG"rCsP.`[Mfw5_+#\w[r2Tj4j7nds/Fyg8Op'2V!'f.yPTKv+<wHpyoEQ6m^PcfC
 O[m-7]U9)F3Uc5F}&\~f1/zpu`7[VkCL=OX%7At0HOfnZ^p.vzLd"\!m&Z7IT?MnE7i&z+oev.Va~n
 d(whEn#~%D9p8eIvyuP@|!jM5`8lMA-te\"#a%4t_$LFy#%zJkX'THo]l<`dVuNtI%nD{k'_xU0(d+
 z\u{<nnm#jsxB.{
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Nov 2003 03:21:05 -0500
From: Gong Su <gongsu@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need some customized function inside tcp_v4_rcv so I wrote a module to
replace tcp_protocol->handler with my own function pointer; and currently
my own tcp_v4_rcv is just a copy of the original tcp_v4_rcv. But as soon
as traffic came in, my machine locks up hard. I can't think of a reason
why it would do so since I've changed other functions the same way, e.g.,
replacing ip_packet_type->func with my own ip_rcv function pointer without
problem. Am I missing something obvious? Thanks for any enlightenment.

-- 
/Gong


