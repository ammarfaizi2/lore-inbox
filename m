Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRCETG2>; Mon, 5 Mar 2001 14:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRCETGS>; Mon, 5 Mar 2001 14:06:18 -0500
Received: from xorn.math.fu-berlin.de ([160.45.45.167]:3712 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S130317AbRCETGH>;
	Mon, 5 Mar 2001 14:06:07 -0500
Date: Mon, 5 Mar 2001 20:06:23 +0100
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: chown bug
Message-ID: <20010305200623.A18183@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The man page says:

       If the owner or group is specified as -1, then that ID is not
       changed.

If user !root says chown("/usr",-1,-1), he gets EPERM.  Why?
He explicitly told the kernel that he does not actually want to change
anything.  Why would the kernel say EPERM?

Felix
