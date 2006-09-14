Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWINI2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWINI2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWINI2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 04:28:31 -0400
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:46699 "HELO
	smtp103.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751471AbWINI2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 04:28:30 -0400
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <330177f4f8f83d0d39034c8f05d4b1f7@nomadgs.com>
Content-Transfer-Encoding: 7bit
Cc: kernel list <linux-kernel@vger.kernel.org>
From: Matthew Locke <matt@nomadgs.com>
Subject: PowerOP summary
Date: Thu, 14 Sep 2006 01:28:25 -0700
To: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.osdl.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of some discussion during the Linux PM summit between 
myself, Todd Poynor, Dominik Brodowski, Mark Gross, Amit Kucheria and a 
few others,  Eugeny and I have been working on getting a power 
management interface called PowerOP accepted.   A good bit of 
discussion has occurred on linux-pm over the last couple months about 
PowerOP interfaces and why its needed.  Here is a short summary 
requested by Greg:

Summary
PowerOP is an interface to create and select operating points.  
Operating points are a collection of platform specific system 
parameters (ie not i/o devices) that affect power consumption.  These 
parameters include cpu frequency, voltages, clock sources and dividers 
and others.  PowerOP provides a platform independent interface to 
control these platform specific parameters.   This interface is a basic 
building block of a power management stack for advanced power 
management on embedded mobile devices.  For those familiar with 
cpufreq, it can be viewed as a redesign of the cpufreq_driver layer to 
be platform independent and enable more advanced governors and policies 
on hardware with lots of power parameters.

Developers
Matthew Locke and Eugeny Mints are the main guys behind PowerOP now but 
many have contributed to get to this point.

A few key points
- PowerOP does not replace cpufreq
- PowerOP authors and advocates are not suggesting to replace cpufreq
- PowerOP is required for doing power management on embedded mobile 
devices
- PowerOP patches are standalone and do not require integration with 
cpufreq or suspend/resume subsystems
- PowerOP does not break anything including existing userspace 
interface and centrino code.

We will resend the patches again for review and discussion.  Each patch 
contains more detailed description.


Matt and Eugeny

