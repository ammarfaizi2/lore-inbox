Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130201AbRCCAyx>; Fri, 2 Mar 2001 19:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRCCAyn>; Fri, 2 Mar 2001 19:54:43 -0500
Received: from cal040031.student.utwente.nl ([130.89.229.165]:60139 "EHLO
	utumno") by vger.kernel.org with ESMTP id <S130201AbRCCAyh>;
	Fri, 2 Mar 2001 19:54:37 -0500
Date: Sat, 3 Mar 2001 01:54:36 +0100
To: linux-kernel@vger.kernel.org
Subject: usleep magically reduces cpu load?
Message-ID: <20010303015436.A10798@utumno.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: SmartList <list@cal040031.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does this use up about 5% CPU (on my system) (pseude code of course)

while (data,size = get_data) {
	write(/dev/dsp,data,size);
}

And this only uses about 0%:

while (data,size = get_data) {
	write(/dev/dsp,data,size);
	usleep(1);
}

I've also tried replacing the usleep with sched_yield() but that did
nothing.

Thomas
-- 
