Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTI3CYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 22:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTI3CYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 22:24:06 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:61344 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263081AbTI3CYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 22:24:04 -0400
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Valdis.Kletnieks@vt.edu, Jamie Lokier <jamie@shareable.org>,
       Muli Ben-Yehuda <mulix@mulix.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_
 bits
References: <Pine.LNX.4.44.0309291918070.26827-100000@gaia.cela.pl>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Sep 2003 11:15:51 +0900
In-Reply-To: <Pine.LNX.4.44.0309291918070.26827-100000@gaia.cela.pl>
Message-ID: <buoisnb3tt4.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski <maze@cela.pl> writes:
> That probably also explains why the convoluted long code with division
> above is faster - the division and multiplication most likely gets
> resolved during compile (since we're dealing with compile time constants)
> into a single shift and results in an execution of bitop 'and' followed by
> 'shift left/right', which due to lacking and conditional branches
> (necessary for ?:) is usually significantly faster due to a lack of 
> branch mispredictions.

Hmmm, on my arch (v850) gcc-2.9x produce different, but equally
efficient (no branches) code for both the old `obvious' expression and
the new `convoluted' expression.  gcc-3.3.x produces the _same_ two
instructions for both expressions, except that the two instructions are
in different orders.  :-)

-Miles
-- 
Freedom's just another word, for nothing left to lose   --Janis Joplin
