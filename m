Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbUCBRrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 12:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCBRrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 12:47:53 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:56841 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261716AbUCBRrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 12:47:51 -0500
To: root@chaos.analogic.com
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.53.0403021000250.19478@chaos> (Richard B. Johnson's
 message of "Tue, 2 Mar 2004 10:02:17 -0500 (EST)")
References: <20040301184512.GA21285@hobbes.itsari.int>
	<c2175f$6hn$1@terminus.zytor.com>
	<m3u1175miy.fsf@lugabout.jhcloos.org>
	<Pine.LNX.4.53.0403021000250.19478@chaos>
Date: Tue, 02 Mar 2004 12:47:40 -0500
Message-ID: <m3ishn5ef7.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Richard> I think /dev/tty, used in the context of any process, always
Richard> refers to the current processes terminal. You should not have
Richard> to "hard-code" a particular terminal.

No, I obviously was ambiguous.  I use:

export HISTFILE=~/.bash_history_${USER}_$(tty|sed s_^/dev/__|tr / _)

in my ~/.bashrc to ensure that each term has a unique and repeatable
HISTFILE.  I do not see any alternative tuple that is unique and
repeatable.

This change makes that idiom useless, with no alternative available.

On a multi-user server the change is clearly the right thing to do,
but on a workstation, laptop or handheld, where few ptys are typically
allocated, the case isn't so clear.

-JimC



