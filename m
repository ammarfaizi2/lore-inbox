Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266164AbSIRLqD>; Wed, 18 Sep 2002 07:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266166AbSIRLqD>; Wed, 18 Sep 2002 07:46:03 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19950 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S266164AbSIRLqC>; Wed, 18 Sep 2002 07:46:02 -0400
Date: Wed, 18 Sep 2002 07:51:03 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async
Message-ID: <20020918075103.B6143@redhat.com>
References: <200209172103.g8HL33N15574@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209172103.g8HL33N15574@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Tue, Sep 17, 2002 at 02:03:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 02:03:02PM -0700, Badari Pulavarty wrote:
> Hi Ben,
> 
> Here is a 2.5.35 patch to make DIO async. Basically, DIO does not
> wait for io completion. Waiting will be done at the higher level
> (same way generic_file_read does).

This looks pretty good.  Andrew Morton has had a look over it too and 
agrees that it should go in after a bit of testing.  Does someone want 
to try comparing throughput of dio based aio vs normal read/write?  It 
would be interesting to see what kind of an effect pipelining aios makes 
and if there are any performance niggles we need to squash.  Cheer,

		-ben
