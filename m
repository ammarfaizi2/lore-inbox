Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIBTDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 15:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTIBTDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 15:03:37 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39697
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261458AbTIBTDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 15:03:35 -0400
Subject: Re: Driver Model
From: Robert Love <rml@tech9.net>
To: jimwclark@ntlworld.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309021943.15875.jimwclark@ntlworld.com>
References: <200309021943.15875.jimwclark@ntlworld.com>
Content-Type: text/plain
Message-Id: <1062530030.29020.16.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Tue, 02 Sep 2003 15:13:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 14:43, James Clark wrote:

> 1. Will the move to a more uniform driver model in 2.6 increase the chances of 
> a given binary driver working with a 2.6+ kernel. 

I don't see how.

> 2. Will the new model reduce the use/need for kernel modules.

No.  The two concepts are really unrelated.

> 3. Will the practice of deliberately breaking some binary only 'tainted' 
> modules prevent take up of Linux. Isn't this taking things too far?

Tainted modules are not "broken" -- they just display a "tainted"
message.  We do not do things to deliberately break binary-only modules.

The driver model has four main benefits, in my eyes:

	- unifies code between the previous desperate driver models
	- creates a device topology, which is needed for power 
	  management
	- allows for things like sysfs and other logical device
	  representations
	- it is just the Right Way to do it

None of your questions are related to the driver model, really.  It is
not a new uniform driver API, if that is what you are thinking.  It is 
a topology/hierarchal abstraction for devices.

	Robert Love


