Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTHFNyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHFNyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:54:05 -0400
Received: from ns.suse.de ([213.95.15.193]:25609 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261874AbTHFNx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:53:58 -0400
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: "lode leroy" <lode_leroy@hotmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70 lockup while write()ing to /dev/hda1
References: <Sea2-F12XkCBewSQRg600027013@hotmail.com>
	<200308061447.46364.fsdeveloper@yahoo.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Let's all show human CONCERN for REVEREND MOON's legal difficulties!!
Date: Wed, 06 Aug 2003 15:38:43 +0200
In-Reply-To: <200308061447.46364.fsdeveloper@yahoo.de> (Michael Buesch's
 message of "Wed, 6 Aug 2003 14:47:33 +0200")
Message-ID: <jehe4ux5wc.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> writes:

|> On Wednesday 06 August 2003 14:32, lode leroy wrote:
|> > main()
|> > {
|> >     int f = open("/dev/hda1", O_RDWR);
|> >     char buffer[8192];
|> >     for(i=0;1;i++) {
|> >        printf("%d\r", i);
|> >        write(f, buffer, sizeof(buffer);
|> 
|> Shouldn't this be:
|> 	write(f, buffer, sizeof(buffer) / sizeof(buffer[0]));

sizeof(char) == 1, always and everywhere.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
