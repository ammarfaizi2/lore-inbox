Return-Path: <linux-kernel-owner+w=401wt.eu-S1753677AbXABTo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbXABTo0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbXABToZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:44:25 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:15586 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbXABToZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:44:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l0jOVXKZHQzToTSGmNS3E7+GfEJiaQHxZKoB5gMwQPQSohxMV81arJ7s8MZFse8nQeB4vO1QspUbcV+LF1A3jnR81qJTIFqVNeVRblBhNkd/x7CgyS+by88bbMyOyLaOL3oEGJvfhVr/bAYeWUNIxwLnU8YRxvS4Vzsni0wyhe0=
Message-ID: <20f65d530701021144p2df613dbvd5fe654ffcd09f91@mail.gmail.com>
Date: Wed, 3 Jan 2007 08:44:24 +1300
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Performance bttv versus sharedmem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is just a general question to understand where the improvement
can be made.

In the first setup, I have these processes:
- mencoder recording from bttv chip at 8 fps (cpu 3.5 %)
- mplayer playing from bttv chip at 10 fps (cpu 2.1 %)

In the second setup, I have these processes:
- mencoder recording from bttv to shared mem at 25 fps (cpu 1.7%)
- mencoder recording from shared mem at 8 fps (cpu 6.1%)
- mplayer playing from shared mem at 10 fps (cpu 3.1 %)

For the shared mem setup, the access to the memory is efficient, only
a memcopy to a buffer. Are the CPU usages inline with what you'd
expect, that the shared mem being almost 2 times the CPU usage? How
can I reduce the CPU usage in the shared mem setup?

Regards
Keith
