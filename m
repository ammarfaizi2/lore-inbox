Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263578AbREYGat>; Fri, 25 May 2001 02:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263579AbREYGaj>; Fri, 25 May 2001 02:30:39 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:36061 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263578AbREYGa3>; Fri, 25 May 2001 02:30:29 -0400
Message-Id: <200105250630.f4P6UR400143@smtp1.Stanford.EDU>
From: Praveen Srinivasan <praveens@stanford.edu>
Subject: Re: [PATCH] DAC960.c - Null ptr fixes
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Reply-To: praveens@stanford.edu
Date: Thu, 24 May 2001 23:31:45 -0700
In-Reply-To: <fa.grcf94v.50qrhi@ifi.uio.no> <fa.nm1gibv.1a2cran@ifi.uio.no> <9eioca$k01$1@news.Stanford.EDU>
Organization: Stanford University
User-Agent: KNode/0.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We revised the DAC960.c patch to include the helpful advice given, as well 
as improving style issues. Is there a good reason why the code has been 
copied and pasted so much? This copying and pasting business multiplies the 
same error very quickly.

Praveen Srinivasan and Frederick Akalin


--- ./drivers/block/DAC960.c.orig       Thu May 24 23:27:46 2001
+++ ./drivers/block/DAC960.c    Thu May 24 23:26:16 2001
@@ -506,8 +506,12 @@
                                      void *DataPointer)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
+  DAC960_V1_CommandMailbox_T *CommandMailbox;
   DAC960_V1_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V1.CommandMailbox;
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Type3.CommandOpcode = CommandOpcode;
@@ -531,9 +535,14 @@
                                       unsigned char TargetID,
                                       void *DataPointer)
 {
+  
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
+  DAC960_V1_CommandMailbox_T *CommandMailbox;
   DAC960_V1_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V1.CommandMailbox;
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
@@ -559,8 +568,12 @@
                                     unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  DAC960_V2_CommandMailbox_T *CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
@@ -597,9 +610,12 @@
                                        unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  DAC960_V2_CommandMailbox_T *CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
-  DAC960_V2_ClearCommand(Command);
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V2.CommandMailbox;
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
   CommandMailbox->ControllerInfo.CommandControlBits
@@ -639,8 +655,12 @@
                                           unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  DAC960_V2_CommandMailbox_T *CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -683,8 +703,12 @@
                                            unsigned int DataByteCount)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  DAC960_V2_CommandMailbox_T *CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -724,8 +748,12 @@
                                           OperationDevice)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
-  DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
+  DAC960_V2_CommandMailbox_T *CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+          return 0;
+  }
+  CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
@@ -1435,8 +1463,12 @@
        InquiryUnitSerialNumber;
       memset(InquiryUnitSerialNumber, 0,
             sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T));
-      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
+      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;    
       Command = DAC960_AllocateCommand(Controller);
+      if(Command == NULL) {
+             return DAC960_Failure(Controller, "COMMAND ALLOCATION");
+      }
+
       CommandMailbox = &Command->V2.CommandMailbox;
       DAC960_V2_ClearCommand(Command);
       Command->CommandType = DAC960_ImmediateCommand;
@@ -6594,6 +6626,8 @@
        create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
                               ControllerProcEntry, DAC960_ProcReadUserCommand,
                               Controller);
+      if(UserCommandProcEntry == NULL) continue;
+
       UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
       Controller->ControllerProcEntry = ControllerProcEntry;
     }









