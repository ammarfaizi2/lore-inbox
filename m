Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUFRCdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUFRCdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 22:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUFRCdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 22:33:40 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:16602 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264961AbUFRCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 22:33:39 -0400
Message-ID: <40D25477.1050006@opensound.com>
Date: Thu, 17 Jun 2004 19:33:27 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Stop the linux kernel madness - SOLVED!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Here's the solution we have found:

With the latest SuSE 2.6.5-7.75 kernel sources:

The problem is that /lib/modules/2.6.5-7.75/build points to
/usr/src/linux-2.6.5-7.75-obj which is some kind of wierd directory
that has:

.  ..  bigsmp  debug  default  out  smp

So simply removing this symlink and putting back a link to
/usr/src/linux-2.6.5-7.75 fixes our problems.

So the question is who is at fault here?. We used KBUILD to
build our modules and obviously the build link in /lib/modules/<kernel>/build
isn't pointing to the correct source tree.


best regards
Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

