Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319144AbSIJOkG>; Tue, 10 Sep 2002 10:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319145AbSIJOkG>; Tue, 10 Sep 2002 10:40:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:7442 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S319144AbSIJOkF>; Tue, 10 Sep 2002 10:40:05 -0400
Date: Tue, 10 Sep 2002 16:44:52 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Block size problem
Message-ID: <20020910144452.GA29827@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  my friend has a following problem: He has FAT filesystem on MO disk
  and computer with SCSI drive reading MO disk. The problem is that
  smallest blocksize supported by the driver is larger than 512 bytes
  which FAT needs. What is the right solution? Copying the device and
  loopback mounting is always possible but it's not nice...  
  Should I fix the driver to support 512 byte sectors (I'm not sure if
  SCSI drivers are supposed to support that)? Another solution I though
  about is creating loopback directly to device but loopback device
  supports only blocksize same as underlying device... So do you think
  it would be nice/useful if loopback device supported any blocksize?

  								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
