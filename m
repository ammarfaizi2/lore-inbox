Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWGLJIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWGLJIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWGLJIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:08:45 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:2309 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1750968AbWGLJIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:08:44 -0400
Date: Wed, 12 Jul 2006 11:08:39 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: linux-kernel@vger.kernel.org
Subject: Oops message with format strings "%8lx" instead of values
Message-ID: <Pine.LNX.4.63.0607121105040.27628@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've got an Oops like this:

Unable to handle kernel paging request at virtual address %8lx
 printing eip:
%8lx
*pde = %8lx
Oops: %
CPU:    0
EIP:    %:[<%8lx>]    <NULL>
EFLAGS: %8lx
eax: %8lx   ebx: %8lx   ecx: %8lx   edx: %8lx
esi: %8lx   edi: %8lx   ebp: %8lx   esp: %8lx
ds: %   es: %   ss: %
Process ^X^X^X^_^X^_^X^X^X^X^X^X^X^X66666667666666666666670? (pid: 0, stackpage=%8lx)
Stack: %8lx %8lx %8lx %8lx %8lx %8lx %8lx %8lx
       %8lx %8lx %8lx %8lx %8lx %8lx %8lx %8lx
       %8lx %8lx %8lx %8lx %8lx %8lx %8lx %8lx
Call Trace:    [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>]
  [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>]
  [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>]
  [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>] [<%8lx>]

and so on - not a single value! Kernel 2.4.30. What could this mean? 
corrupted stack? But function calling / returning worked yet... Never seen 
like that one before...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
