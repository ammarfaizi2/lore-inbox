Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbTJKRBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTJKRBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:01:35 -0400
Received: from lvs00-fl-n13.valueweb.net ([216.219.253.195]:34764 "EHLO
	ams013.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S263352AbTJKRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:01:33 -0400
Message-ID: <3F88372B.1000209@coyotegulch.com>
Date: Sat, 11 Oct 2003 13:00:27 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 thoughts: common well-architected object model
References: <20031011160621.22378.qmail@web13006.mail.yahoo.com>
In-Reply-To: <20031011160621.22378.qmail@web13006.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asdfd esadd wrote:
> So let me restate the need:
> 
> * a unified well architected core component model
> which is extensible from OS services to application
> objects
> 
> * the object model should be defined from the kernel
> layer for process/events/devices etc. up and not
> started at the application layer

A few years ago, I would have agreed with you. But in today's reality, 
an OS-based object model provides a singular target for malicious attack.

The theory of reusable binary components is seductive, yet it leads to 
many of the flaws seen in Windows. All too often, Windows applications 
install components which may be newer or even older than the ones they 
replace; while Microsoft has made strides with component versioning, the 
problem still exists. These days, many Windows applications ship their 
own version of "common" components, to avoid incompatibilities with 
whatever may be installed system-wide.

OS-based object models also suffer from bit rot. New hardware and 
software features require API changes, such that older objects gradually 
become incompatible with newer requirements.

Windows also has the advantage of focusing on a single hardware 
platform, where Linux runs on an incredible variety of systems.

Were Linux to implement an object model, it would need careful and 
considerate design to address security, versioning, extensibility, and 
portability.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

