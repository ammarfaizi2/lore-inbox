Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269841AbTGKJMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269842AbTGKJMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:12:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:56791 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269841AbTGKJMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:12:42 -0400
Date: Fri, 11 Jul 2003 15:03:54 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: tty: Line disc gets reset after close
Message-ID: <20030711093354.GA1312@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a rs232 serial port, If i try 
# stty -F /dev/ttyS0 line 2 
and then execute
# stty -F /dev/ttyS0 -a
line disc was shown as line = 0.  Further investigation  showed that
close on the tty fd and subsequent open to it resets the line disc to 0.

My question is, is this the expected behaviour?  
If change flags like icanon, it remains inspite of close and opens.  I'd
expect ldisc to remain that way too.

Thanks,
Kiran
