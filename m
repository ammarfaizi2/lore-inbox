Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264670AbRFZTpB>; Tue, 26 Jun 2001 15:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265101AbRFZTov>; Tue, 26 Jun 2001 15:44:51 -0400
Received: from goblin.sharat.co.il ([62.90.60.186]:48648 "EHLO
	goblin.sharat.co.il") by vger.kernel.org with ESMTP
	id <S264670AbRFZTog>; Tue, 26 Jun 2001 15:44:36 -0400
Date: Tue, 26 Jun 2001 22:44:09 +0300
From: Ilya Konstantinov <lkml@future.galanet.net>
To: linux-kernel@vger.kernel.org
Subject: Finding out the name behind a /dev/dsp device
Message-ID: <20010626224409.A24182@goblin.sharat.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear LKML,

(Please CC your replies to me, since I'm not subscribed)

How can I find out the module name which handles a /dev/dsp* device
and/or the full name of the Sound Card I'd be addressing by it?

For /dev/mixer* devices, there's a SOUND_MIXER_INFO ioctl to retrieve
the Mixer chip name, but I couldn't find a similar call for /dev/dsp
devices. Parsing /etc/modules.conf doesn't seem correct, since a single
module can support multiple installed cards of the same type (thus
creating /dev/dsp entries for multiple cards), and since drivers can be
compiled statically.

This functionality is essential when building an application which
prompts the user to select a Sound Output Device from a list of
installed sound cards (avoiding exposing the user to a plain list of
dsp devices). Using the mixer chip's name isn't exactly friendly, and
still doesn't let you know which dsp device belongs to which mixer.
