Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276824AbRJCA6q>; Tue, 2 Oct 2001 20:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276822AbRJCA6h>; Tue, 2 Oct 2001 20:58:37 -0400
Received: from h226-58.adirondack.albany.edu ([169.226.226.58]:45224 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S276818AbRJCA63>;
	Tue, 2 Oct 2001 20:58:29 -0400
Date: Tue, 2 Oct 2001 20:58:56 -0400
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10/Preemt STOP bug
Message-ID: <20011002205856.A19554@bouncybouncy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there is a bug in 2.4.10 or the preemptable patch that causes the STOP
signal to not work right 19 times out of 20 or so.

This is most easily seen by running 'seq 1 100000' in a terminal and pressing
control Z or using kill -STOP the proccess stops, but the parent process never
comes back, kill -CONT has to be used in order to get the proccess back.

CPU usage my be a factor in this, yes(1) backgrounds correctly more often then
seq does.

There are no problems with fg/CONT.

-Justin
