Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264304AbUEDKQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUEDKQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 06:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbUEDKQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 06:16:36 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:37132 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S264304AbUEDKQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 06:16:28 -0400
Date: Tue, 4 May 2004 12:16:53 +0200
From: DervishD <raul@pleyades.net>
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freezes with cdrecord
Message-ID: <20040504101652.GB105@DervishD>
Mail-Followup-To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>,
	linux-kernel@vger.kernel.org
References: <200405041145.05894.Alexander.Zviagine@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405041145.05894.Alexander.Zviagine@cern.ch>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Alexander :)

 * Alexander ZVYAGIN <Alexander.Zviagine@cern.ch> dixit:
> During the burning process everything is fine and
> smooth. But very close to the end, the computer freezes
> again for ~10-20 seconds. It happens in 'fixating' stage
> of the writing process.
[...]
> Any explanations why those freezes happen?

    It maybe has to do with the lack of zerocopy support (no DMA
transfer) in certain parts of the process. For example, under 2.4.x
you don't have zerocopy when writing audio, and maybe during fixation
DMA is not used, neither. I'm not an expert in this issue, but I
think that it may be the cause.

    Which kernel are you using? Which kind of recorder?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
