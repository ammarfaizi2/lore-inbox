Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVFRSci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVFRSci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVFRS3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:29:04 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:17135 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262183AbVFRSZD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:25:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OqYaV7V5YI2hWrFgwzRa1jVeDA6t3gS/AM57AG5aYuOY08AyHKH0grYgJlAER2u0YWVWz9iEb8ilnqTKupgY2QxSkcN0snvD+lHyj2lB07TnwGlPmxD479AF5d7WFH+aGIqFJ9UdUSEtI/ptrWHSflvZbygoQer9GY58ioIngZg=
Message-ID: <3b0ffc1f05061811251c12718f@mail.gmail.com>
Date: Sat, 18 Jun 2005 14:25:01 -0400
From: Kevin Radloff <radsaq@gmail.com>
Reply-To: Kevin Radloff <radsaq@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Logic bug in 2.6.12 conservative cpufreq governor?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The conservative cpufreq governor's "ignore_nice" sysfs parameter is
reversed from what I would expect:

% cat /sys/devices/system/cpu/cpu0/cpufreq/conservative/ignore_nice
1

.. While it's not ignoring nice'd processes. Changing it to 0 causes
it to ignore them. That would seem to make sense only if it's supposed
to mean "ignore niceness of processes" vs "ignore nice'd processes"...
Is that so?

If it is, then wouldn't the name make more sense as "ignore_niceness"
or something equally less ambiguous? :)

Please CC me as I'm not on the list.

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://saqataq.us/
