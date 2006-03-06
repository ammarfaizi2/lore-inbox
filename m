Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWCFAlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWCFAlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 19:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWCFAlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 19:41:14 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:7899 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1751099AbWCFAlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 19:41:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17419.34083.172540.639486@lemming.engeast.baynetworks.com>
Date: Sun, 5 Mar 2006 19:41:07 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
In-Reply-To: <20060305231312.GA25673@mars.ravnborg.org>
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org>
	<20060305231312.GA25673@mars.ravnborg.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: "Paul D. Smith" <psmith@gnu.org>
Reply-To: "Paul D. Smith" <psmith@gnu.org>
Organization: GNU's Not Unix!
X-OriginalArrivalTime: 06 Mar 2006 00:41:09.0620 (UTC) FILETIME=[A95B5B40:01C640B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%% Sam Ravnborg <sam@ravnborg.org> writes:

  sr> Thanks Paul.
  sr> Adapted to -rc4 and applied to my kbuild tree which I have pushed out.
  sr> For reference I added the applied patch below.

OK.  Note that this:

  sr> -.PHONY: tar%pkg
  sr> +PHONY += tar%pkg
  sr>  tar%pkg:

won't do what you expect.  tar%pkg is a pattern rule, but .PHONY doesn't
take patterns so you're declaring the actual file named literally
'tar%pkg' to be phony.


Cheers!

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.paulandlesley.org
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
