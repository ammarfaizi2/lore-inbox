Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318973AbSIJLof>; Tue, 10 Sep 2002 07:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSIJLof>; Tue, 10 Sep 2002 07:44:35 -0400
Received: from gherkin.frus.com ([192.158.254.49]:46472 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S318973AbSIJLof>;
	Tue, 10 Sep 2002 07:44:35 -0400
Message-Id: <m17ojWD-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.34: ide.c:3673: redefinition of `init_module'
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2002 06:49:21 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Saw the subject problem in 2.5.33 as well.  It shows up for
configurations where IDE is modular (e.g., pure SCSI systems with,
perhaps, USB or PCMCIA/CardBus IDE support) rather than built-in.

The full compilation error text is:

ide.c:3673: redefinition of `init_module'
ide.c:3651: `init_module' previously defined here
{standard input}: Assembler messages:
{standard input}:9387: Error: Symbol init_module already defined.

The fix is probably simple, but if anyone thinks I'm going to touch
the IDE "tar baby"...   :-)

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
