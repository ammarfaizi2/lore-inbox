Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDKQsN (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTDKQsN (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:48:13 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:58100 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S261281AbTDKQsL (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:48:11 -0400
Date: Fri, 11 Apr 2003 12:57:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] first try for swap prefetch
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304111259_MC3-1-3405-E07F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:


> We could possibly avoid this by swapping the pages back
>in after one minute of inactivity, then letting the
>disk spin down.


  Why not also write pages out to swap before it's really necessary?
If they were left mapped but marked as having up-to-date copies
on swap, they could be discarded immediately if the system needed
memory.  (Of course if they got written to they would have to be
paged out again.)

--
 "Let's fight until six, and then have dinner," said Tweedledum.
 --Lewis Carroll, _Through the Looking Glass_
