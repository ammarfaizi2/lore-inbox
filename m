Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130172AbQL0BWC>; Tue, 26 Dec 2000 20:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbQL0BVw>; Tue, 26 Dec 2000 20:21:52 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:51151 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S130172AbQL0BVp>;
	Tue, 26 Dec 2000 20:21:45 -0500
From: Michael Elizabeth Chastain <chastain@cygnus.com>
Date: Tue, 26 Dec 2000 16:52:15 -0800
Message-Id: <200012270052.QAA29361@craftsman.cygnus.com>
To: esr@snark.thyrsus.com, torvalds@transmeta.com
Subject: Re: [KBUILD] How do we handle autoconfiguration?
Cc: anedah-9@sm.luth.se, cate@student.ethz.ch, kaih@khms.westfalen.de,
        linux-kbuild@torque.net, linux-kernel@vger.kernel.org, timw@splhi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

esr> # PROCESSOR is string valued; we capture stdout from the probe
esr> derive PROCESSOR from "myprobe1.sh"
esr> 
esr> # FOOFEATURE is boolean; we look at the return status from myprobe2.py 
esr> derive FOOFEATURE from "myprobe2.py"

I think this is cool.

esr> (kbuild people, this is one reason I want ifdefs gone from the
esr> makefiles.  The autoconfigurator, whether it's Giacomo's or not,
esr> should be able to pass FOO=n to tell CML2 that a given feature is
esr> definitely not present.)

Yeah, we have to make an essential transition from 3-valued logic
("y"/"m"/"n" in some contexts and "y"/"m"/NULL in other contexts) to
4-valued logic ("y"/"m"/"n"/NULL).

Michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
