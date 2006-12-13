Return-Path: <linux-kernel-owner+w=401wt.eu-S964933AbWLMNGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWLMNGz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWLMNGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:06:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2431 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964933AbWLMNGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:06:53 -0500
Date: Wed, 13 Dec 2006 14:07:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: drivers/media/dvb/frontends/dib?000*: stack usage problems
Message-ID: <20061213130701.GF3851@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions each allocate a > 1.5 kB *_state struct on the 
stack:
- dib7000m_i2c_enumeration()
- dib7000p_i2c_enumeration()
- dib3000mc_i2c_enumeration()

Considering that the whole stack might be only 4 kB, functions shouldn't 
use 1.5 kB of the stack.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

